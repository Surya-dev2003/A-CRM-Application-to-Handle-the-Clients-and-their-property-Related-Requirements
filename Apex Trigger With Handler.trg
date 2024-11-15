public class FlightReminderScheduledJob implements Schedulable {


    public void execute(SchedulableContext sc) {

        sendFlightReminders();

    }


    private void sendFlightReminders() {

        // Query for flights departing within the next 24 hours

        List<Flight__c> upcomingFlights = [SELECT Id, Name, DepartureDateTime__c FROM Flight__c

                                           WHERE DepartureDateTime__c >= :DateTime.now()

                                           AND DepartureDateTime__c <= :DateTime.now().addDays(1)];


        for (Flight__c flight : upcomingFlights) {

            // Customize the logic to send reminder emails

            // For this example, we'll print a log message; replace this with your email sending logic.

            System.debug('Sending reminder email for Flight ' + flight.Name + ' to ' + flight.ContactEmail__c);


            // Example: Send email using Messaging.SingleEmailMessage

            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

            email.setToAddresses(new List<String>{ flight.ContactEmail__c });

            email.setSubject('Flight Reminder: ' + flight.Name);

            email.setPlainTextBody('This is a reminder for your upcoming flight ' + flight.Name +

                                   ' departing on ' + flight.DepartureDateTime__c);

            Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ email });

        }

    }

}

