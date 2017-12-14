package com.example.guestbook;

import org.restlet.Application;
import org.restlet.Request;
import org.restlet.Response;
import org.restlet.Restlet;
import org.restlet.routing.Router;

public class AttendanceApplication extends Application {

    /**
     * Creates a root Restlet that will receive all incoming calls.
     */
    @Override
    public Restlet createInboundRoot() {
        
     // Create a root router
        Router router = new Router(getContext());        

        // Attach the handlers to the root router
        router.attach("/take", AttendanceResource.class);
        router.attach("/list", AttendanceResource.class);
        router.attach("/student", StudentAttendanceResource.class);

        return router;
    }
}