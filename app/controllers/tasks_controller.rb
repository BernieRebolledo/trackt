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

  # Método para guardar datos de la tarea nueva.
  def create
    # Creo una variable de instancia asignandole el valor de una tarea nueva
    # Y pasandole los parametros que admitimos para esta.
    @task = Task.new(task_params)
    # Le asigno la tarea al usuario en sesión
    @task.user_id = session[:user]
    if @task.save
      flash[:notice] = "Task created"
      redirect_to "/tasks"
    else
      flash[:notice] = "Task is not created, try again!"
      redirect_to "/tasks"
    end
  end

  # Vista del perfil de tareas
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
    redirect_to "/tasks"
  end

  #Método para finalizar el tiempo de las tareas cambiando el valor de status a true.
  def stop
    @task = Task.find(params[:id])
    @task.update_attributes(status: true)
    redirect_to tasks_path  
  end

  #Método para cerrar la sesión del usuario.
  def delete
    session[:user] = nil
    redirect_to "/"
  end

  private

  #Método para requerir los parámetros de la creación de tareas.
  def task_params
    params.require(:task).permit(:name, :description, :status, :hours, :mins, :secs, :time)
  end	
end
