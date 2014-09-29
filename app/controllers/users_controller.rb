class UsersController < ApplicationController

  def add
  	@addResponse = {}
  	@addResponse[:errCode] = User.add(params[:user], params[:password])
  	if @addResponse[:errCode] >= 0
  		@addResponse[:count] = @addResponse[:errCode]
  		@addResponse[:errCode] = User::SUCCESS
  	end
  	render :json => @addResponse
  end

  def login
  	@loginResponse = {}
  	@loginResponse[:errCode] = User.login(params[:user], params[:password])
  	if @loginResponse[:errCode] >= 0
  		@loginResponse[:count] = @loginResponse[:errCode]
  		@loginResponse[:errCode] = User::SUCCESS
  	end
  	render :json => @loginResponse
  end

  def home
  end

end
