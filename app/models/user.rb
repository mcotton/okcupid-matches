class User < ActiveRecord::Base
  attr_accessible :is_male, :is_matched, :matched_with, :name, :orientation
  before_create :find_matches

  def find_matches
    if self.is_male
      case self.orientation
      when 'Straight'
        User.all.each do |u|
          if !u.is_matched
            if likes_guys(u.orientation, u.is_male) and !u.is_male
              update_matches(self, u)
              return true
            end
          end
        end
      when 'Gay'
        User.all.each do |u|
          if !u.is_matched
            if likes_guys(u.orientation, u.is_male) and u.is_male
              update_matches(self, u)
              return true
            end
          end
        end 
      when 'Bi'
        User.all.each do |u|
          if !u.is_matched
            if likes_guys(u.orientation, u.is_male) and u.orientation != 'Straight'
              update_matches(self, u)
              return true
            end
          end
        end 
      end
    else
      case self.orientation
      when 'Straight'
        User.all.each do |u|
          if !u.is_matched
            if likes_girls(u.orientation, u.is_male) and u.is_male
              update_matches(self, u)
              return true
            end
          end
        end
      when 'Gay' 
        User.all.each do |u|
          if !u.is_matched
            if likes_girls(u.orientation, u.is_male) and !u.is_male
              update_matches(self, u)
              return true
            end
          end
        end 
      when 'Bi'
        User.all.each do |u|
          if !u.is_matched
            if likes_girls(u.orientation, u.is_male) and u.orientation != 'Straight'
              update_matches(self, u)
              return true
            end
          end
        end 
      end
    end
  end

  def update_matches(first, second)
    first.is_matched = true
    second.is_matched = true
    first.matched_with = second.name
    second.matched_with = first.name
    second.save
  end

  def likes_girls(orientation, is_male)
    if !is_male
      if orientation != 'Straight'
        return true
      end
    end
    if is_male
      if orientation != 'Gay'
        return true
      end
    end
    return false
  end

  def likes_guys(orientation, is_male)
    if is_male
      if orientation != 'Straight'
        return true
      end
    end
    if !is_male 
      if orientation != 'Gay'
        return true
      end
    end
    return false
  end 
end
