class SessionsController < ApplicationController
  def create
    response = Faraday.post "https://github.com/login/oauth/access_token?client_id=#{ENV["GITHUB_CLIENT"]}&client_secret=#{ENV["GITHUB_SECRET"]}&code=#{params[:code]}", {}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user?access_token=#{session[:token]}"
    username = JSON.parse(user_response.body)["login"]
    session[:username] = username

    redirect_to '/'
  end
end