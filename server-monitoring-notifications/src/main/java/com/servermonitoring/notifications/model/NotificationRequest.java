package com.servermonitoring.notifications.model;

public class NotificationRequest {

	private String dateTime;
	private String summary;
	private String serverName;
	private String processName;
	private String severity;
	private String detail;
	private String action = "";

    public NotificationRequest() {
    }

	public NotificationRequest(String summary, String dateTime, String serverName, String processName,
			String severity, String detail, String action) {
		super();
		this.summary = summary;
		this.dateTime = dateTime;
		this.serverName = serverName;
		this.processName = processName;
		this.severity = severity;
		this.detail = detail;
		this.action = action;
		
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getDateTime() {
		return dateTime;
	}

	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}

	public String getServerName() {
		return serverName;
	}

	public void setServerName(String serverName) {
		this.serverName = serverName;
	}

	public String getProcessName() {
		return processName;
	}

	public void setProcessName(String processName) {
		this.processName = processName;
	}

	public String getSeverity() {
		return severity;
	}

	public void setSeverity(String severity) {
		this.severity = severity;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

}
