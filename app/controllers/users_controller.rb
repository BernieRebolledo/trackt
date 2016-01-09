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
    @user = User.new(user_params)
    if @user.save
      session[:user] = @user.id
      flash[:notice] = "Su usuario se ha creado."
      redirect_to @user
    else
      flash[:notice] = "No se pudo crear el usuario, este correo ya está en uso!!"
      render "/index"
    end
  end

  # Método para guardar datos de twitter.
  def connect
    if env["omniauth.auth"]
        @user = User.where(provider_uid: env["omniauth.auth"]["uid"]).first
        unless @user
          @user = User.new
          @user.name = env["omniauth.auth"]["extra"]["raw_info"]["name"]
          @user.email = env["omniauth.auth"]["extra"]["raw_info"]["email"]
          @user.image = env["omniauth.auth"]["info"]["image"]
          @user.verified = env["omniauth.auth"]["extra"]["raw_info"]["verified"]
          @user.provider_uid = env["omniauth.auth"]["uid"]
          if @user.save
            session[:user] = @user.id
            redirect_to "/users/show"
          else
            flash[:notice] = "Los datos no se pudieron guardar."
            redirect_to "/users/show"
          end
        else
          session[:user] = @user.id
        redirect_to "/users/show"
        end
      elsif params[:error]
        render plain: "#{params[:error]} #{params[:error_reason]}", content_type: "application/plain"
      else  
        render plain: "No se peudo conectar con #{params[:provider]}", content_type: "application/plain"
      end
  end

  # Vista del perfil de usuario
  def show
    # Compruebo si existe una sesión de usuario.
      if session[:user]
      # Busco en la tabla de usuarios uno con el id de esa sesión existente.
        # Se le asigna el valor de la busqueda a la variable de instancia.  
        @user = User.find(session[:user])
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
  
end
