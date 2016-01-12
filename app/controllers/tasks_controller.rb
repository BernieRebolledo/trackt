class TasksController < ApplicationController
	
	def index
    # Compruebo si existe una sesión de usuario.
      if session[:user]
        # Busco en la tabla de usuarios uno con el id de esa sesión existente.
        # Se le asigna el valor de la busqueda a la variable de instancia.
        @user = User.find(session[:user])
      end
      # Renderizo la vista index. /views/tasks/index.html.erb
      render "/tasks/index"
  end

  # Método para guardar datos del usuario nuevo.
  def create
    # Creo una variable de instancia asignandole el valor de un nuevo usuario.
    # Y pasandole los parametros que admitimos para un usuario.
    @task = Task.new(task_params)
    @task.user_id = session[:user]
    if @task.save
      flash[:notice_success] = "La tarea ha sido creada."
      redirect_to "/tasks"
    else
      flash[:notice_fail] = "La tarea no se pudo crear intenta de nuevo"
      redirect_to "/tasks"
    end
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
    # # Compruebo si existe una sesión de usuario.
      if session[:user]
      # Busco en la tabla de usuarios uno con el id de esa sesión existente.
        # Se le asigna el valor de la busqueda a la variable de instancia.  
        @user = User.find(session[:user])
      end
    render "/tasks/index"
  end


  def update
  end

  def time
      if session[:user]
        # Busco en la tabla de usuarios uno con el id de esa sesión existente.
        # Se le asigna el valor de la busqueda a la variable de instancia.
        @user = User.find(session[:user])
      end
      # @task = Task.find(@task.id)
      @stime = @task.created_at
      @ftime = Time.zone.now
      @sec_diff = (@stime-@ftime).to_i.abs
      @hours = @sec_diff / 3600
      @sec_diff -= @hours * 3600
      @mins = @sec_diff / 60
      @sec_diff -= @mins * 60
      @secs = @sec_diff
      puts "========================="
      puts
      printf "%02dh:%02dm:%02ds", @hours, @mins, @secs
      puts
      puts "========================="
      puts @stime
      puts @ftime
      render "/tasks/index"
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
