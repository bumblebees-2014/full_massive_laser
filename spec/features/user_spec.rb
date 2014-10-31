require 'rails_helper'

RSpec.feature '#Register' do
	scenario 'Successful registration' do

		visit '/users/new'

		within "form" do

			fill_in('user[name]', :with => 'Some Guy')
      fill_in('user[email]', :with => 'user@example.com')
      fill_in('user[password]', :with => 'password')
      find('[type="submit"]').click
		end
		  expect(page).to have_selector("[data-name='success']", text: 'Your account has been created successfully')
	end
end