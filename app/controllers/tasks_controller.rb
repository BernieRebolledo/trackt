class TasksController < ApplicationController
	
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
    @task = Task.new(task_params)
    # if @user.save
    #   session[:user] = @user.id
    #   flash[:notice] = "Su usuario se ha creado."
    #   redirect_to "/users/show"
    # else
    #   flash[:notice] = "No se pudo crear el usuario, este correo ya está en uso!!"
    #   render "/index"
    # end
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


  def update
  end

  #Método para cerrar la sesión del usuario.
  def delete
    session[:user] = nil
    redirect_to "/"
  end

  private

  #Método para requerir los parámetros de la creación de usuario sin proveedor.
  def task_params
    params.require(:task).permit(:name, :description, :stime, :ftime, :time)
  end	
end
