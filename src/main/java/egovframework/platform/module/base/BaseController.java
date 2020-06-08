package egovframework.platform.module.base;

import egovframework.platform.module.common.DefaultRestTemplate;
import egovframework.platform.module.common.vo.UserVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 시스템 공통 controller
 */
@CrossOrigin
public class BaseController {
	protected Logger logger;
	protected UserVO loginUserInfo;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Autowired
	protected DefaultRestTemplate restService;

	@Autowired
	protected HttpServletRequest context;

	public BaseController() {
		super();
	}

	public void setLoginUserInfo() {
		System.out.println("context:" + context);
		if (context != null) {
			HttpSession session = context.getSession();

			System.out.println("session:" + session);

			if (session != null) {
				logger.info("setLoginUserInfo1!!!" + loginUserInfo + "," + session.getAttribute("userInfoPlatform"));
				loginUserInfo = (UserVO) session.getAttribute("userInfoPlatform");
				logger.info("setLoginUserInfo2!!!" + loginUserInfo);
			}
		}
	}
}