IdolCalendar.controllers  do
  get :index do
    @events = Event.filter{ start >= Date.today }.order(:start, :end).paginate(params[:page].to_i.nonzero? || 1, 200)
    render 'index'
  end

  get :about do
    render 'about'
  end
end
