if defined?(::Excon) && !NewRelic::Agent.config[:disable_excon] && !(ENV['NEWRELIC_ENABLE'].to_s =~ /false|off|no/i)
  Excon::Connection.class_eval do
    def request_with_newrelic_trace(params, &block)
      metrics = ["External/#{params[:host]}/Excon::Connection/#{params[:method]}", "External/#{params[:host]}/all", "External/all"]
      if NewRelic::Agent::Transaction.recording_web_transaction?
        metrics << "External/allWeb"
      else
        metrics << "External/allOther"
      end
      self.class.trace_execution_scoped metrics do
        request_without_newrelic_trace(params, &block)
      end
    end
    alias request_without_newrelic_trace request
    alias request request_with_newrelic_trace
  end
end
