# This is an example of an Additions module. Additions modules are used to add custom columns to
# the Streamlined views. The value returned can be a string, raw HTML, etc.
#
# Methods in an Additions module have access to all the columns on the current record. For example,
# we could create an addition that combines the first and last name of a person this way:
#
#   module PersonAdditions
#     def first_and_last_name
#       "#{first_name} #{last_name}"
#     end
#   end
#
# Here, we're specifying an additional column called "personnel" that will
# always display the static value 30.
#
module TeamAdditions 
  def personnel
    30
  end
end

# Streamlined currently requires that you manually include Additions modules in your model class.
# This process of inclusion will be automated at some point in the future.
Team.class_eval { include TeamAdditions }

# The UI class is the heart of Streamlined's declarative system. It enables you to control which
# columns are displayed in various views, which buttons show up, whether or not columns are linked,
# and so on. The wiki has a good overview of the declarations available to you.
#
class TeamUI < Streamlined::UI
  user_columns  :name, { :html_options => { :class => "team_input_field" }, :link_to => {:action => 'show'}},
                :city, { :html_options => { :class => "team_input_field", :size => 20 }},
                :sport, { :create_only => true, :enumeration => Team::Sport::SPORTS },
                :home_state, { :show_view => [:link], :edit_in_list => false },
                :coach,
                :players,
                :personnel
end