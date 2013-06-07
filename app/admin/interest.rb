ActiveAdmin.register Interest, :as => 'students' do
  menu :label => 'Explore Interests'

  controller do
    def scoped_collection
      Interest.user_interests
    end
  end

  index :title => 'Administrator Dashboard' do
    column 'Name' do |interest|
      link_to("#{User.find(interest.user_id).first} #{User.find(interest.user_id).last}", "mailto:#{User.find(interest.user_id).email}")
    end
    column :social, :sortable => :social do |interest|
      "#{number_to_percentage(interest.social / User.find( interest.user_id ).total.to_f * 100, :precision => 0)} (#{interest.social})"
    end
    column :investigative, :sortable => :investigative do |interest|
      "#{number_to_percentage(interest.investigative / User.find( interest.user_id ).total.to_f * 100, :precision => 0)} (#{interest.investigative})"
    end
    column :realistic, :sortable => :realistic do |interest|
      "#{number_to_percentage(interest.realistic / User.find( interest.user_id ).total.to_f * 100, :precision => 0)} (#{interest.realistic})"
    end
    column :enterprising, :sortable => :enterprising do |interest|
      "#{number_to_percentage(interest.enterprising / User.find( interest.user_id ).total.to_f * 100, :precision => 0)} (#{interest.enterprising})"
    end
    column :conventional, :sortable => :conventional do |interest|
      "#{number_to_percentage(interest.conventional / User.find( interest.user_id ).total.to_f * 100, :precision => 0)} (#{interest.conventional})"
    end
    column :artistic, :sortable => :artistic do |interest|
      "#{number_to_percentage(interest.artistic / User.find( interest.user_id ).total.to_f * 100, :precision => 0)} (#{interest.artistic})"
    end
    column :t3
    # default_actions
  end

  filter :social
  filter :investigative
  filter :realistic
  filter :enterprising
  filter :conventional
  filter :artistic
  filter :t3

  form do |f|
    f.inputs "Interest Details" do
      f.input :social
      f.input :investigative
      f.input :realistic
      f.input :enterprising
      f.input :conventional
      f.input :artistic
    end
    f.actions
  end
end
