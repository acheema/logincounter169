class TestapiController < ApplicationController

  def resetFixture
  	resetResponse = {}
  	resetResponse[:errCode] = User.TESTAPI_resetFixture()
  	render :json => resetResponse
  end

  def unitTests
  	  ENV['RAILS_ENV'] = 'test'
      output = `ruby -Itest test/models/user_test.rb`
      value = output.split(/\r?\n/)
      status = value[-1].split(",")
      totalRuns = Integer(status[0].scan(/\d+/).first)
      failedRuns = Integer(status[2].scan(/\d+/).first)
      render :json => {:nrFailed => failedRuns, :output => output, :totalTests => totalRuns}
  end

end
