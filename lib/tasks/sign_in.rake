namespace 'sign_in' do
  desc 'Clear expired sign_ins'
  task :sweep => [:environment] do
    SignIn.sweep
  end
end
