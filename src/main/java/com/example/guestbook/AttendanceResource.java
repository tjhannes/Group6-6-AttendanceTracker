package com.example.guestbook;

import java.util.List;
import java.util.ListIterator;

import org.restlet.Request;
import org.restlet.Response;
import org.restlet.data.Form;
import org.restlet.data.Parameter;
import org.restlet.representation.Representation;
import org.restlet.resource.Get;
import org.restlet.resource.Post;
import org.restlet.resource.ServerResource;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;

public class AttendanceResource extends ServerResource 
{
	@Post
	public void takeAttendance(Representation entity)
	{
		final Form form = new Form(entity);
		String student_id = form.getFirstValue("student_id");
		int group_id = Integer.parseInt(form.getFirstValue("group_id"));
		int week_id = Integer.parseInt(form.getFirstValue("week_id"));
	  	  
		Attendance attendance = new Attendance(student_id,group_id,week_id,true);
		ObjectifyService.ofy().save().entity(attendance).now();
	}

	@Get
	public String listAllAttendances()
	{
		String allAttendances = "Attendances\n\n";
	
		int listingLimit = (getQuery().getValues("show_count")==null?0:Integer.parseInt(getQuery().getValues("show_count")));
		String filterByGroup = getQuery().getValues("show_group_id");
		List<Attendance> attendanceList;
		if(filterByGroup != null)
		{
			attendanceList = ObjectifyService.ofy()
	    	          .load()
	    	          .type(Attendance.class) // We want only Greetings
	    	          .ancestor(Key.create(Attendance.class, "attendance"))    // Anyone in this book
	    	          .filter("tutorial_group_id", Integer.parseInt(filterByGroup))
	    	          .order("-date")       // Most recent first - date is indexed.
	    	          .limit(listingLimit)
	    	          .list();
		}
		else
		{
			attendanceList = ObjectifyService.ofy()
	    	          .load()
	    	          .type(Attendance.class) // We want only Greetings
	    	          .ancestor(Key.create(Attendance.class, "attendance"))    // Anyone in this book
	    	          .order("-date")       // Most recent first - date is indexed.
	    	          .limit(listingLimit)
	    	          .list();
		}    	

    	for (ListIterator<Attendance> iter = attendanceList.listIterator(); iter.hasNext(); ) 
    	{
    	    Attendance element = iter.next();
    	    allAttendances += "attendance_id: " + element.id + "\n";
    	    allAttendances += "student_id: " + element.student_id + "\n";
    	    allAttendances += "tutorial_group_id: " + element.tutorial_group_id + "\n";
    	    allAttendances += "week_id: " + element.week_id + "\n";
    	    allAttendances += "presented: " + element.presented + "\n\n";
    	}  	

        return allAttendances;
	}
}