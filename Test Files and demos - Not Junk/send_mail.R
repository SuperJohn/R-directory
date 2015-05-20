library(sendmailR)
?sendmail

sendmail_options(smtpServer="smtp.gmail.com")

# gmail requires the angle bracket syntax for from/to (i.e. <myemail@myaddress.com>)
from <- "<johnkirkhoughton1@gmail.com>"
to <- "<johnkirkhoughton1@gmail.com>"
subject <- "R automated message"
msg <- list("It works!", mime_part(iris))
sendmail(from, to, subject, msg)


install.packages("mailR", dep = T)

library(mailR)
library(sendmailR)

send.mail(from = "johnkirkhoughton1@gmail.com",
          to = "johnkirkhoughton1@gmail.com",
          subject = "Subject of the email",
          body = "Body of the email",
          smtp = list(host.name = "aspmx.l.google.com", port = 25),
          authenticate = FALSE,
          send = TRUE)
