class User < ActiveRecord::Base
  attr_accessible :is_male, :is_matched, :matched_with, :name, :orientation
  before_create :find_matches

  def find_matches
    if self.is_male == true
      if self.orientation == 'Straight'
        User.all.each do |u|
          if u.is_matched == false
            if likes_chicks(u.orientation, u.is_male) == true
              u.is_matched = true
              u.matched_with = self.name
              self.is_matched = true
              self.matched_with = u.name
              u.save
              return true
            end
          end
        end
      elsif self.orientation != 'Straight'
        User.all.each do |u|
          if u.is_matched == false
            if likes_chicks(u.orientation, u.is_male) == true
              u.is_matched = true
              u.matched_with = self.name
              self.is_matched = true
              self.matched_with = u.name
              u.save
              return true
            end
          end
        end 
      end
    else
      if self.orientation == 'Straight'
        User.all.each do |u|
          if u.is_matched == false
            if likes_chicks(u.orientation, u.is_male) == true
              u.is_matched = true
              u.matched_with = self.name
              self.is_matched = true
              self.matched_with = u.name
              u.save
              return true
            end
          end
        end
      elsif self.orientation != 'Straight'
        User.all.each do |u|
          if u.is_matched == false
            if likes_guys(u.orientation, u.is_male) == true
              u.is_matched = true
              u.matched_with = self.name
              self.is_matched = true
              self.matched_with = u.name
              u.save
              return true
            end
          end
        end 
      end
    end 
  end

  def likes_chicks(orientation, gender)
    if gender == false
      if orientation != 'Straight'
        return true
      end
    end
    if gender == true
      if orientation != 'Gay'
        return true
      end
    end
    return false
  end

  def likes_guys(orientation, gender)
    if gender == true
      if orientation != 'Straight'
        return true
      end
    end
    if gender == false
      if orientation != 'Gay'
        return true
      end
    end
    return false
  end 

  def likes_guys(orientation, gender)
    if gender == true
      if orientation != 'Straight'
        return true
      end
    end
    if gender == false
      if orientation != 'Gay'
        return true
      end
    end
    return false
  end 
end
