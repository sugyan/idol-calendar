# -*- coding: utf-8 -*-
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

  get :area, :with => :area do
    cids = Calendar.select(:id).filter(:area => params[:area]).select_map(:id)
    error 404 unless cids.length > 0

    cond = Sequel.expr(:calendar_id => cids)
    case params[:area]
    when 'hokkaido'
      @area_name = '北海道'
      words = %w(北海道)
    when 'tohoku'
      @area_name = '東北'
      words = %w(青森 岩手 宮城 秋田 山形 福島)
    when 'kanto'
      @area_name = '関東'
      words = %w(茨城 栃木 群馬 埼玉 千葉 東京 神奈川)
    when 'chubu'
      @area_name = '中部・甲信越'
      words = %w(新潟 富山 石川 福井 山梨 長野 岐阜 静岡 愛知)
    when 'kansai'
      @area_name = '関西'
      words = %w(三重 滋賀 京都 大阪 兵庫 奈良 和歌山)
    when 'chushi'
      @area_name = '中国・四国'
      words = %w(鳥取 島根 岡山 広島 山口 徳島 香川 愛媛 高知)
    when 'kyushu'
      @area_name = '九州・沖縄'
      words = %w(福岡 佐賀 長崎 熊本 大分 宮崎 鹿児島 沖縄)
    end
    words.each do |word|
      cond = Sequel.|(cond, Sequel.ilike(:summary, "%#{ word }%"), Sequel.ilike(:description, "%#{ word }%"))
    end
    @events = Event.filter(Sequel.expr{ start >= Date.today }, cond).order(:start, :end).paginate(params[:page].to_i.nonzero? || 1, 200)
    render 'area'
  end

  get :search do
    render 'search'
  end

  get :result, :map => '/search/result' do
    cond = Sequel.expr(:calendar_id => params[:cid])
    params[:word].split(/\s/).each do |word|
      cond = Sequel.|(cond, Sequel.ilike(:summary, "%#{ word }%"), Sequel.ilike(:description, "%#{ word }%"))
    end
    @events = Event.filter(Sequel.expr{ start >= Date.today }, cond).order(:start, :end).paginate(params[:page].to_i.nonzero? || 1, 200)
    render 'result'
  end

  get :about do
    render 'about'
  end
end
