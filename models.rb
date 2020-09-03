
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "sqlite3:db/development.db")

class Season < ActiveRecord::Base
 has_many :litclats
end

class Litclat < ActiveRecord::Base
  belongs_to :Season
  has_many :teams
end

class Team < ActiveRecord::Base
  belongs_to :Litclat
  has_many :members
end

class Member < ActiveRecord::Base
  belongs_to :Team
end

class AllDat < ActiveRecord::Base

end
