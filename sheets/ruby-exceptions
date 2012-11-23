# NET::HTTP Exceptions

  begin
    response = Net::HTTP.post_form("...")
  rescue Timeout::Error,
         Errno::EINVAL,
         Errno::ECONNRESET,
         EOFError,
         Net::HTTPBadResponse,
         Net::HTTPHeaderSyntaxError,
         Net::ProtocolError => e
    #...
  end

# Sending Emails

  SERVER_EXCEPTIONS = [TimeoutError,
                       IOError,
                       Net::SMTPUnknownError,
                       Net::SMTPServerBusy,
                       Net::SMTPAuthenticationError]


  CLIENT_EXCEPTIONS = [Net::SMTPFatalError,
                       Net::SMTPSyntaxError]

  EXCEPTIONS = SERVER_EXCEPTIONS + CLIENT_EXCEPTIONS

  begin
    Mailer.deliver_message
  rescue *CLIENT_EXCEPTIONS
    flash[:warning] = 'The email address suppised is invalid. please check for spelling mistakes'
    redirect_to #...
  rescue *SERVER_EXCEPTIONS
    flash[:warning] = 'We encountered an internal issue while attempting to deliver this email. Please try again in a few minutes'
    redirect_to #...
  end
