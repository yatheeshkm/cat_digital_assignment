class UserController < ApplicationController
  require 'net/http'
  require 'rest-client'
  require 'json'

    def user
        @message = "Hello, Have a nice day..!"
        @user = User.all
    end

    def create_user
      if request.post?
        @name = params[:name]
        @email = params[:email]
        @address = params[:address]
        puts "#{@name} , #{@email},#{@address}"
        @user = User.new(name: @name, email: @email, address: @address)
        if @user.save
          result = RestClient.post(ENV['ApiUrl'],
          {
            'data': {
             'action': 'user creation',
             'name': @name,
             'email': @email,
             'address': @address
            }
            
          } 
        )
        if result.code == 200
          flash[:success] = "User is created and informed to webook sucessfully!"
         else
          flash[:success] = "User is created and informed to webook !"
        end
        redirect_to '/user'
      end  
     end
    end

    def edit_user
      @user = User.find_by(id: params[:id])

    end 

    def update_user
      @id = params[:id]
      @name = params[:name]
      @email = params[:email]
      @address = params[:address]
      @user = User.find(@id)
      if @user.update(name: @name, email: @email, address: @address)
        result = RestClient.post(ENV['ApiUrl'],
        {
          'data': {
           'action': 'user update',
           'name': @name,
           'email': @email,
           'address': @address
          }
          
        } 
      )
      
      if result.code == 200
        flash[:success] = "User is updated and informed to webook sucessfully!"
       else
        flash[:success] = "User is updated and not informed to webook !"
      end
      redirect_to '/user'
       end
    end

    def delete_user
      @id = params[:id]
      @user = User.find_by(id: @id)
     if @user.destroy
      result = RestClient.post(ENV['ApiUrl'],
      {
        'data': {
         'action': 'user delete',
         'name': @user.name,
         'email': @user.email,
         'address': @user.address
        }
        
      } 
    )
    if result.code == 200
      flash[:success] = "User is deleted and informed to webook sucessfully!"
     else
      flash[:success] = "User is deleted and not informed to webook !"
    end
    redirect_to '/user'
     end
    end

    def add_user
      @user = User.new
    end  
end
