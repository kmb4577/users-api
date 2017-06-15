module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern


  # self.included(base_class) do

  # end
  included(base_class) do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end



end







#
# # create a ruby class for a person class
# # method to calc age, couple access methods
# require 'date'
#
# class Person
#   def initialize(fname, lname, dob)
#     # Instance variables
#     @fname = fname
#     @lname = lname
#     @birthday = Date.new(dob[0].to_i, dob[1].to_i, dob[2].to_i)
#   end
#
#   def age
#     now = Date.today
#     years_old = now.year - @birthday.year
#
#     if (Date.today.month < @birthday.month) && (Date.today.day < @birthday.day)
#       years_old = years_old - 1
#     end
#   end
#
#   def birthday
#     @birthday
#   end
#
#   def fname
#     @fname
#   end
#
#   def lname
#     @lname
#   end
#
#   def update_fname(new_fname)
#     @fname = new_fname
#   end
#
#   def update_birthday(birthday)
#     @birthday = birthday
#   end
#
#   # def puts_valid_birthday?
#   #   puts Person.valid_birthday?(@birthday) ? "#{@fname} has a valid birthday!" : "#{@fname} has an invalid birthday :("
#   # end
#
# end
#
#
#
#
# # module PeopleClassMethods
# #   def valid_birthday?(birthday)
# #     birthday.is_a? Date
# #   end
# # end
#
# # Person.extend(PeopleClassMethods)
#
#
#
# module PersonModule
#   # Runs when the module is included
#   def self.included(base_class)
#     # You can extend the base class
#     base_class.extend(PeopleClassMethods)
#     # you can include new instance methods
#     base_class.send(:include, PeopleInstanceMethods)
#
#     base_class.class_eval do
#       def update_fname(new_fname)
#         @fname = "hahahahah I overwrote your function!"
#       end
#       class << self
#         def valid_birthday?(birthday)
#           !(birthday.is_a? Date)
#           puts "BAHHAHAHAHHAHAHAHH"
#         end
#       end
#       # alias_method_chain :update_birthday, :patch
#       alias_method :update_birthday_without_patch, :update_birthday
#       alias_method :update_birthday, :update_birthday_with_patch
#     end
#
#     # alias_method_chain :update_birthday, :patch
#
#     # alias_method :update_birthday_without_patch, :update_birthday
#     # alias_method :update_birthday, :update_birthday_with_patch
#   end
#
#
#   module PeopleClassMethods
#     def valid_birthday?(birthday)
#       birthday.is_a? Date
#     end
#   end
#
#   module PeopleInstanceMethods
#     def update_lname(new_lname)
#       @lname = new_lname
#     end
#
#     def update_birthday_with_patch(birthday)
#       @birthday = birthday
#     end
#   end
# end
#
#
# # Actually include your module in the class
# Person.send(:include, PersonModule)
#
#
# ###############################################################################
# p1 = Person.new("Kaitlin", "Brockway", ["1992", "7", "29"])
# p2 = Person.new("Tom", "Miller", ["2000", "3", "28"])
#
# puts Person.valid_birthday?(p1.birthday) ? "#{p1.fname} has a valid birthday!" : "#{p1.fname} has an invalid birthday :("
# puts Person.valid_birthday?(p2.birthday) ? "#{p2.fname} has a valid birthday!" : "#{p2.fname} has an invalid birthday :("
#
# puts p1.inspect
# puts p1.age.inspect
# p1.update_fname("Kater")
# p1.update_lname("New Last NAME")
# puts p1.inspect
#
# puts "updating #{p2.fname}'s Birthday :::::::::::::::::::"
# p2.update_birthday(Date.new(p1.birthday.year - 1, p1.birthday.month, p1.birthday.day))
# puts p2.birthday.inspect
#
# # create a module that you include, and a module that you extend your class that you made (edited)
# add some new methods via the module rather than in the class itself