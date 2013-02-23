IdolCalendar.controllers  do
  get :index do
    @events = Event.filter{ start >= Date.today }.order(:start, :end).paginate(params[:page].to_i.nonzero? || 1, 200)
    render 'index'
  end

  get :event, :with => :id do
    if @event = Event[params[:id]]
      render 'event'
    else
      error 404
    end
  end

  get :search do
    render 'search'
  end

  get :result, :map => '/search/result' do
    cond = Sequel.expr(:calendar_id => params[:cid])
    params[:word].split(/\s/).each do |word|
      cond = Sequel.|(cond, Sequel.ilike(:summary, "%#{ word }%"), Sequel.ilike(:description, "%#{ word }%"))
    end
    @events = Event.filter(cond).order(:start, :end).paginate(params[:page].to_i.nonzero? || 1, 200)
    render 'result'
  end

  get :about do
    render 'about'
  end
end
