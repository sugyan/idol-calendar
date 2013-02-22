IdolCalendar.controllers  do
  get :index do
    today = DateTime.now.new_offset('+09:00').to_date.to_datetime
    @events = Event.filter{ start >= today }.order(:start).paginate(params[:page].to_i.nonzero? || 1, 200)
    render 'index'
  end

  get :about do
    render 'about'
  end
end
