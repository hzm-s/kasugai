namespace 'sign_up' do
  desc 'Clear expired sign_ups'
  task :sweep => [:environment] do
    SignUp.sweep
  end
end
