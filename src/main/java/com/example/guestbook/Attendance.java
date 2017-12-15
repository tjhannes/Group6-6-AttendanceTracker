package com.example.guestbook;

import java.util.Date;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

@Entity
public class Attendance {
	  @Parent Key<Guestbook> theAttendance;
	  @Id public Long id;
	  public String student_id;
	  public int week_id;
	  public boolean presented;
	  public String tutorial_info;
	  @Index public int tutorial_group_id; 	//Without Index keyword, ObjectifyService 
	  @Index public Date date;				//cannot filter results according to variable
	  
	  public Attendance()
	  {
		  date = new Date();
	  }
	  
	  public Attendance(String student_id, int tutorial_group_id, int week_id, boolean presented) 
	  {
		  this();
		  theAttendance = Key.create(Guestbook.class, "attendance");
		  this.student_id = student_id;
		  this.tutorial_group_id = tutorial_group_id;
		  this.week_id = week_id;
		  this.presented = presented;
		  
		  String[] tutorialInfo =  {
				  	"Time: Mondays, 9:00 - 11:00 | Room: 01.011.018 | Tutor: Ana",
					"Time: Mondays, 13:45 - 15:15 | Room: 01.011.018 | Tutor: Sebastian",
					"Time: Mondays, 15:15 - 16:45 | Room: 01.011.018 | Tutor: Sebastian",
					"Time: Tuesdays, 15:00 - 17:00 | Room: 01.011.018 | Tutor: Ehsan",
					"Time: Wednesdays, 10:00 - 12:00 | Room: 00.011.038 | Tutor: Mohsen",
					"Time: Wednesdays, 12:00 - 14:00 | Room: 01.011.018 | Tutor: Saahil"};
		  this.tutorial_info = tutorialInfo[this.tutorial_group_id-1];
	  }

}
