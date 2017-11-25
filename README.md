# Group6-6-AttendanceTracker

**Showing Attendances:**
`/attendance/list`  
Shows all saved attendances

**Parameters:**

 - show count

Limits the number of attendances shown, not having this parameter or having it as 0 will show all attendances

 - show_group_id

Filters the attendances, so that attendances only with the given group id will be shown

Example

    /attendance/list?show_count=5?show_group_id=1