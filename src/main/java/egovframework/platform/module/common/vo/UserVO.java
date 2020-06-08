package egovframework.platform.module.common.vo;

import egovframework.platform.module.common.vo.DefaultVO;

public class UserVO extends DefaultVO {
	public String USER_ID;
	public String USER_NAME;
	public String USER_PASS;
	public String USE_YN;
	public String RMK;
	public String USER_IP;
	public String IS_NEW;
	public String LOGIN_USR_ID;

	public boolean USR_OK;

	public UserVO() {
		super();
	}

	public UserVO(boolean USR_OK) {
		this.USR_OK = USR_OK;
	}
}