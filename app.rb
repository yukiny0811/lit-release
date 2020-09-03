require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'sinatra/cookies'
require './models.rb'

enable :sessions

get '/' do
  if AllDat.find_by(dataname: "nowseasonid").present?
    if Season.find_by(id: AllDat.find_by(dataname: "nowseasonid").datavalue).present?
      @season = Season.find_by(id: AllDat.find_by(dataname: "nowseasonid").datavalue).seasonname
      sum = 0
      count = 0
      allCount = 0
      unsaved = 0
      released = 0
      classSum = Array.new
      classCount = 0
      classAllCount = Array.new
      classNameArray = Array.new
      classReleasedCount = Array.new
      @shinnchoku = [0, 0, 0, 0, 0, 0]
      if Season.find_by(id: AllDat.find_by(dataname: "nowseasonid").datavalue).litclats.present?
        Season.find_by(id: AllDat.find_by(dataname: "nowseasonid").datavalue).litclats.all.each do |c|
          classNameArray.push(c.classname)
          classSum.push(0)
          classAllCount.push(0)
          classReleasedCount.push(0)
          c.teams.all.each do |t|
            t.members.all.each do |m|
              if m.percentage.present?
                sum += m.percentage
                classSum[classCount] += m.percentage
                if m.percentage >= 100
                  released += 1
                  classReleasedCount[classCount] += 1
                  @shinnchoku[5] += 1
                elsif m.percentage >= 80
                  count += 1
                  @shinnchoku[4] += 1
                elsif m.percentage >= 60
                  count += 1
                  @shinnchoku[3] += 1
                elsif m.percentage >= 40
                  count += 1
                  @shinnchoku[2] += 1
                elsif m.percentage >= 20
                  count += 1
                  @shinnchoku[1] += 1
                elsif m.percentage >= 0
                  count += 1
                  @shinnchoku[0] += 1
                else
                  count += 1
                end
              else
                unsaved += 1
              end
              allCount += 1
              classAllCount[classCount] += 1
            end
          end
          classCount += 1
        end
      end
      classAverage = Array.new

      if allCount.present?
        @shinnchoku[0] = @shinnchoku[0].to_f / allCount.to_f * 100
        @shinnchoku[1] = @shinnchoku[1].to_f / allCount.to_f * 100
        @shinnchoku[2] = @shinnchoku[2].to_f / allCount.to_f * 100
        @shinnchoku[3] = @shinnchoku[3].to_f / allCount.to_f * 100
        @shinnchoku[4] = @shinnchoku[4].to_f / allCount.to_f * 100
        @shinnchoku[5] = @shinnchoku[5].to_f / allCount.to_f * 100
      end


      classReleasedPercent = Array.new
      classNameArray2 = Array.new
      for s in 0..classCount-1 do
        classAverage.push(classSum[s].to_f / classAllCount[s].to_f)
        classReleasedPercent.push(classReleasedCount[s].to_f / classAllCount[s].to_f)
        classNameArray2[s] = classNameArray[s]
      end
      if sum.present? && count.present? && released.present? && allCount.present? && unsaved.present?
        @averagePercentAllClass = sum.to_f / count.to_f
        @releasedPercentAllClass = released.to_f / allCount.to_f
        @unsavedPercentAllClass = unsaved.to_f / allCount.to_f
        @unreleasedPercentAllClass = count.to_f / allCount.to_f
      else
        @averagePercentAllClass = "no data"
        @releasedPercentAllClass = "no data"
        @unsavedPercentAllClass = "no data"
        @unreleasedPercentAllClass = "no data"
      end




      for i in 0..classCount-2 do
        (classCount-1).downto(i+1) do |j|
          if classAverage[j] < classAverage[j-1]
            t = classAverage[j];
            p = classNameArray[j];
            classAverage[j] = classAverage[j-1]
            classNameArray[j] = classNameArray[j-1]
            classAverage[j-1] = t
            classNameArray[j-1] = p
          end
        end
      end

      for i in 0..classCount-2 do
        (classCount-1).downto(i+1) do |j|
          if classReleasedPercent[j] < classReleasedPercent[j-1]
            t = classReleasedPercent[j];
            p = classNameArray2[j];
            classReleasedPercent[j] = classReleasedPercent[j-1]
            classNameArray2[j] = classNameArray2[j-1]
            classReleasedPercent[j-1] = t
            classNameArray2[j-1] = p
          end
        end
      end

      if classReleasedPercent.count >= 1 && classNameArray2.count >= 1 && classAverage.count >= 1 && classNameArray.count >= 1

        @classReleasedPercent = classReleasedPercent
        @classnameArray2 = classNameArray2

        @classAverage = classAverage
        @classnameArray = classNameArray

      else

        @classReleasedPercent = "no data"
        @classnameArray2 = "no data"

        @classAverage = "no data"
        @classnameArray = "no data"

      end
      
    else
      @season = "no season selected"
    end
  else
    @season = "no season selected"
  end
  ua = request.user_agent
  if ua.include?("Android") || ua.include?("iPhone") || ua.include?("iPod") || ua.include?("iPad")
    erb :indexM
  else
    erb :index
  end
end

post '/settei' do
  pass = params[:pass]
  if pass == "lifeistech"
    redirect '/settei'
  else
    redirect '/'
  end
end










get '/settei' do
  if cookies[:admin] || session[:admin]
    if AllDat.find_by(dataname: "nowseasonid").present?
      if Season.find_by(id: AllDat.find_by(dataname: "nowseasonid").datavalue).present?
        @nowseason = Season.find_by(id: AllDat.find_by(dataname: "nowseasonid").datavalue).seasonname
      else
        @nowseason = "no season selected"
      end
    else
      @nowseason = "no season selected"
    end
    erb :settei
  else
    redirect '/setteipass'
  end
end

get '/setteipass' do
  if cookies[:admin] || session[:admin]
    redirect '/settei'
  end
  erb :setteipass
end

post '/setteipass' do
  if params[:ismentor].present?
    cookies[:admin] = true
    session[:admin] = true
  end
end

get '/seasonsettei' do
  if cookies[:admin] || session[:admin]
    erb :seasonsettei
  else
    redirect '/setteipass'
  end
end

get '/dbsettei' do
  if cookies[:admin] || session[:admin]
    erb :dbsettei
  else
    redirect '/setteipass'
  end
end


post '/dbsettei' do
  if params[:seasonname].present?
      Season.create(seasonname: params[:seasonname], isthisseason: false)
      redirect '/dbsettei'
  end
  if params[:seasonid].present?
    Season.find_by(id: params[:seasonid]).destroy
  end
  if params[:seasonselectid].present?
    $seasonIDG = params[:seasonselectid]
  end
end

post '/classsettei' do
  if params[:seasonid].present?
    $seasonIDG = params[:seasonid]
  end
  if params[:classname].present?
    Litclat.create(classname: params[:classname], season_id: $seasonIDG)
    redirect '/classsettei'
  end
  if params[:classid].present?
    Litclat.find_by(id: params[:classid]).destroy
  end
  if params[:classselectid]
    $classIDG  = params[:classselectid]
  end
end

get '/classsettei' do
  if cookies[:admin] || session[:admin]
    if !Season.find_by(id: $seasonIDG).nil?
      @litclatsS = Season.find_by(id: $seasonIDG).litclats
    end
    erb :classsettei
  else
    redirect '/setteipass'
  end
end

post '/teamsettei' do
  if params[:classid].present?
    $classIDG = params[:classid]
  end
  if params[:teamname].present?
    Team.create(mentorname: params[:teamname], litclat_id: $classIDG)
    redirect '/teamsettei'
  end
  if params[:teamid].present?
    Team.find_by(id: params[:teamid]).destroy
  end
  if params[:teamselectid].present?
    $teamIDG = params[:teamselectid]
  end
end

get '/teamsettei' do
  if cookies[:admin] || session[:admin]
    if !Litclat.find_by(id: $classIDG).nil?
      @teamS = Litclat.find_by(id: $classIDG).teams
    end
    erb :teamsettei
  else
    redirect '/setteipass'
  end
end

post '/membersettei' do
  if params[:teamid].present?
    $teamIDG = params[:teamid]
  end
  if params[:membername].present?
    # Member.create(membername: params[:membername], team_id: $teamIDG, percentage: 0)
    Member.create(membername: params[:membername], team_id: $teamIDG)
    redirect '/membersettei'
  end
  if params[:memberid].present?
    Member.find_by(id: params[:memberid]).destroy
  end
end

get '/membersettei' do
  if cookies[:admin] || session[:admin]
    if !Team.find_by(id: $teamIDG).nil?
      @memberS = Team.find_by(id: $teamIDG).members
    end
    erb :membersettei
  else
    redirect '/setteipass'
  end
end

post '/seasonsettei' do
  if params[:seasonsetteiid].present?
    if AllDat.find_by(dataname: "nowseasonid").present?
      AllDat.find_by(dataname: "nowseasonid").update(datavalue: params[:seasonsetteiid])
    else
      AllDat.create(dataname: "nowseasonid", datavalue: params[:seasonsetteiid])
    end
  end
  @value = AllDat.find_by(dataname: "nowseasonid").datavalue
  erb :temp
end

get '/userpass' do
  erb :userpass
end

get '/userpass2' do
  if Member.where(membername: params[:membernametext]).present?
    @tempList = Member.where(membername: params[:membernametext]).all
    @memberList = Array.new
    @tempList.each do |m|
      if Litclat.find_by(id:Team.find_by(id:m.team_id).litclat_id).season_id == AllDat.find_by(dataname: "nowseasonid").datavalue
        @memberList.push(m)
      end
    end
  end
  erb :userpass2
end


get '/usermain' do
  @percentage = session[:selectedMember].percentage
  @member = session[:selectedMember]
  ua = request.user_agent
  if ua.include?("Android") || ua.include?("iPhone") || ua.include?("iPod") || ua.include?("iPad")
    erb :Musermain
  else
    erb :usermain
  end
end

post '/usermain' do
  if params[:memberid].present?
    session[:selectedMember] = Member.find_by(id: params[:memberid])
  end
  if params[:percentage].present?
    Member.find_by(id: params[:memberid]).update(percentage: params[:percentage])
    session[:selectedMember] = Member.find_by(id: params[:memberid])
  end
end

post '/memberinfo' do
  if params[:memberid].present?
    session[:memberinfo] = params[:memberid]
  end
end

get '/memberinfo' do
  if cookies[:admin] || session[:admin]
    @member = Member.find_by(id: session[:memberinfo])
    @percentage = @member.percentage
    erb :memberinfo
  else
    redirect '/setteipass'
  end
end
