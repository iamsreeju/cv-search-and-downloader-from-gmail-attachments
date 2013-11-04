# ecoding: utf-8

class HomeController < ApplicationController

  # User dashboard
  def dashboard

  end

  # For dwonloading and reading career email attachments
  # Needed packages catdoc & pdftotext
  def get_email_attachments
		resp = @resp

		params["email"] ||= ""
		params["password"] ||= ""

		# To avoid timedout issue of ajax call, all mails are loaded using multiple ajax calls with some limit  
		# Initialy 5 mails are only loaded to send first response in least time. 
		# params recursion will be false for initial call.
		params["limit"] = params["recursion"] == "true" ? 100 : 100 

		#25 : 5

		# Authorize and process attachments in mail account
		resp = Resume.gmail_attachments(resp, params)

		render :json => resp
  end


  # Matching keyword values with resume text in db
  # For "php" - all resumes which have the word php will be listed
  # For "php jquery" - all resumes which have both php & jquery will be listed
  def resumes_matching
		resp = @resp
		# Prcessing keyword values for matching resume list
		resp = Resume.resumes_matching(resp, params)
		render :json => resp
  end


end
