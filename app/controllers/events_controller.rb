class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
    @events_np =Event.where('is_private' => false).paginate(:page => params[:page], :per_page => 15)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
  end

  def list_private
    @events = Event.paginate(:page => params[:page], :per_page => 15)
    @events_private = current_user.events
    render "index"
  end

  # GET /events/new
  def new
    @club = Club.all
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
	def create
		@event = Event.new(events_params)
    
	    if @event.save
    	 	redirect_to events_path
    	 	flash[:notice] = "Vous avez créé l'évènement! Congratulations!!!"

    	else
      		render :new
      		flash[:error] = "Vous n'avez pas créé l'évènement!"

      	end

	end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
	def events_params
    	params.require(:event).permit(:title, :date_start, :date_end)
  	end
end
