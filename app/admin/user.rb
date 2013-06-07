ActiveAdmin.register User do

  index do
    column :first
    column :last
    column :email
    column :location
    column :last_sign_in_at
    column 'Top Interests' do |user|
      user.interest.t3
    end
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    h3 "#{user.first} #{user.last}"
    h5 user.email
    p "Show selected careers plus some details, show selected jobs and notes, allow comments, show a graph of interests"
    div class: 'user-block clearfix' do
      panel 'Selected Careers' do
        table do
          tr
            th 'Career'
            th style: 'text-align: center;' do 'O*NET' end
            th 'Related Major'
          user.careers.each do |career|
            tr
              td h5 career.title
              td style: 'text-align: center;' do h5 link_to('[x]', "http://www.onetonline.org/link/summary/#{career.code}", target: '_blank') end
              td h5 'Philosophy'
          end
        end
      end
    end
    div class: 'user-block clearfix' do
      panel 'Interests' do
        canvas id: "my2Chart", width: "auto", height: "250", style: 'margin: 0 auto; padding: 25px 15px; float: left;'
        script "user_dashboard.show_interests_graph(#{Interest.humanize(Interest.return_array_of_interests(user))});"
        br
        br
        hr
        h6 "Realistic: #{(user.interest.realistic / user.total.to_f * 100).round}%"
        h6 "Investigative: #{(user.interest.investigative / user.total.to_f * 100).round}%"
        h6 "Artistic: #{(user.interest.artistic / user.total.to_f * 100).round}%"
        h6 "Social: #{(user.interest.social / user.total.to_f * 100).round}%"
        h6 "Enterprising: #{(user.interest.enterprising / user.total.to_f * 100).round}%"
        h6 "Conventional: #{(user.interest.conventional / user.total.to_f * 100).round}%"
        hr
        div style: 'clear: both' do end
      end
    end
    div style: 'clear: both' do end
    div class: 'user-block clearfix' do
      panel 'Selected Jobs' do
        user.jobs.each do |job|
          h5 job.name
        end
      end
    end
    div class: 'user-block clearfix' do
      active_admin_comments
    end
  end
end
