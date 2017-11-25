package com.example.guestbook;

import java.util.Date;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

@Entity
public class Attendance {
	  @Parent Key<Attendance> theAttendance;
	  @Id public Long id;
	  public String student_id;
	  public int week_id;
	  public boolean presented;
	  @Index public int tutorial_group_id; 	//Without Index keyword, ObjectifyService 
	  @Index public Date date;				//cannot filter results according to variable
	  
	  public Attendance()
	  {
		  date = new Date();
	  }
	  
	  public Attendance(String student_id, int tutorial_group_id, int week_id, boolean presented) 
	  {
		  this();
		  theAttendance = Key.create(Attendance.class, "attendance");
		  this.student_id = student_id;
		  this.tutorial_group_id = tutorial_group_id;
		  this.week_id = week_id;
		  this.presented = presented;
	  }

}
