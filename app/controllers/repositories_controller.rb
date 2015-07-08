class RepositoriesController < ApplicationController
  def index
    redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV["GITHUB_CLIENT"]}&scope=repo" if !session[:token]
    
    response = Faraday.get "https://api.github.com/user/repos?access_token=#{session[:token]}"
    @response_array = JSON.parse(response.body)
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}"}
    redirect_to '/'
  end
end
