class EncountersController < ApplicationController

    get "/encounters" do
        proc = Proc.new {
        @encounters = Encounter.all
        @encounters_name_lat_long = []
        @encounters.each do |e|
            @encounters_name_lat_long << {name: e.name, lat: e.latitude, lng: e.longitude}
        end
        erb :'encounters/index'
    }
    redirect_if_not_logged_in(proc)
    end

    get '/encounters/new' do
        proc = Proc.new{
        erb :'encounters/new'
        }
        redirect_if_not_logged_in(proc)
    end

    post '/encounters' do
        
        proc = Proc.new {

        @encounter = Encounter.new(params)
        
            @user = current_user
            @user.encounters << @encounter
            if @encounter.save
        
                redirect "/encounters/#{@encounter.id}"
            else
                redirect "/encounters/new"
            end
     

    }
        redirect_if_not_logged_in(proc)
    end

    get '/encounters/:id/edit' do
        proc = Proc.new{
            
            @encounter = Encounter.find(params[:id])
            @user = @encounter.user
            if @user == current_user
                erb :'encounters/edit'
            else 
                redirect "/encounters/#{@encounter.id}"
            end
        }
        redirect_if_not_logged_in(proc)
    end

    patch '/encounters/:id' do
        @encounter = Encounter.find(params[:id])
        
        params.delete(:_method)
        params.delete(:id)
        
        @encounter.update(params)
        @encounter.save
        redirect "/encounters/#{@encounter.id}"
    end

    get '/encounters/:id' do
        proc = Proc.new{

        @encounter = Encounter.find(params[:id])
        @user = @encounter.user
        erb :'encounters/show'
        }

        redirect_if_not_logged_in(proc) 
    end

    delete '/encounters/:id' do 
        @encounter = Encounter.find(params[:id])
        @user = @encounter.user
        if @user = current_user
            @encounter.delete
            redirect "/users/#{@user.slug}"
        else
            redirect "/users/#{current_user.slug}"
        end


    end


end

