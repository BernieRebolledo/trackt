class UsersController < ApplicationController

  def index
    # Compruebo si existe una sesión de usuario.

      if session[:user]
        # Busco en la tabla de usuarios uno con el id de esa sesión existente.
        # Se le asigna el valor de la busqueda a la variable de instancia.
        @user = User.find(session[:user])
      end
      # Renderizo la vista index. /views/index.html.erb
      render "/index"
  end

  # Método para guardar datos del usuario nuevo.
  def create


    # Creo una variable de instancia asignandole el valor de un nuevo usuario.
    # Y pasandole los parametros que admitimos para un usuario.
    # @user = User.new(user_params)
    # if @user.save
    #   session[:user] = @user.id
    #   flash[:notice] = "Su usuario se ha creado."
    #   redirect_to @user
    # else
    #   flash[:notice] = "No se pudo crear el usuario, este correo ya está en uso!!"
    #   render "/index"
    # end
  end

  # Método para guardar datos de twitter.
  def connect
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user] = @user.id
    redirect_to "/users/show"
    # if env["omniauth.auth"]
    #     @user = User.where(provider_uid: env["omniauth.auth"]["uid"]).first
    #     unless @user
    #       @user = User.new
    #       @user.name = env["omniauth.auth"]["extra"]["raw_info"]["name"]
    #       @user.email = env["omniauth.auth"]["extra"]["raw_info"]["email"]
    #       @user.image = env["omniauth.auth"]["info"]["image"]
    #       @user.verified = env["omniauth.auth"]["extra"]["raw_info"]["verified"]
    #       @user.provider_uid = env["omniauth.auth"]["uid"]
    #       if @user.save
    #         session[:user] = @user.id
    #         redirect_to @user
    #       else
    #         flash[:notice] = "Los datos no se pudieron guardar."
    #         redirect_to "/"
    #       end
    #     else
    #       if @user.save
    #       session[:user] = @user.id
    #       flash[:notice] = 'Logueado satisfactoriamente'
    #       redirect_to @user
    #       else
    #       flash[:notice] = 'Inactivo viejo'
    #       redirect_to "/"
    #       end
    #     end
    #   elsif params[:error]
    #     render plain: "#{params[:error]} #{params[:error_reason]}", content_type: "application/plain"
    #   else  
    #     render plain: "No se pudo conectar con #{params[:provider]}", content_type: "application/plain"
    #   end
  end

  # Vista del perfil de usuario
  def show
    
    # Compruebo si existe una sesión de usuario.
      if session[:user]
      # Busco en la tabla de usuarios uno con el id de esa sesión existente.
        # Se le asigna el valor de la busqueda a la variable de instancia.  
        @user = User.find(session[:user])
      end
      render "profile"
  end

  def login
    user = User.where(email: user_params[:email]).first
    if user && user.provider_uid
      render plain: "Hola #{user.name} puedes indicar sesión por medio de facebook o twitter", content_type: "application/plain"
    else  
      if user && user.password == user_params[:password]
        session[:user] = user.id
        redirect_to user
      else
        flash[:notice] = "Su correo o la contraseña no existen"
        redirect_to "/"
      end
    end
  end

  def update
  end

  #Método para cerrar la sesión del usuario.
  def delete
    session[:user] = nil
    redirect_to "/"
  end

  

  private


  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  protected

  def auth_hash
    request.env['omniauth.auth']   
  end
end
