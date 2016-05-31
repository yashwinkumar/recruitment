class Admin::UserPolicy < ApplicationPolicy
	def index?
		user.admin?
	end
		
	def new
		true?
	end 

	def create?
		true
	end
end