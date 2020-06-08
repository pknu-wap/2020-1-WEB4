package egovframework.platform.module.admin.controller;

import egovframework.platform.module.admin.service.AD010Service;
import egovframework.platform.module.base.BaseController;
import egovframework.platform.module.common.vo.ResultVO;
import egovframework.platform.module.common.vo.UserVO;
import egovframework.platform.util.Constants;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@CrossOrigin
@RestController
public class AD010Controller extends BaseController {

	@Autowired
	private AD010Service ad010Service;

	public AD010Controller() {
		super();

		logger = LoggerFactory.getLogger(this.getClass());
	}

	@RequestMapping("/ad010Page.do")
	public ModelAndView ad010Page() throws Exception {
		logger.info("requestURL:" + context.getRequestURL());

		ModelAndView view = new ModelAndView("/admin/ad010Page");

		try {
		} catch (Exception e) {
			logger.error(Constants.ERROR_SQL, e);
		}

		return view;
	}

	@RequestMapping(value = "/ad010/list", method = RequestMethod.GET)
	public List<UserVO> ad010List(@RequestParam String userId) throws Exception {
		logger.info("requestURL:" + context.getRequestURL());

		if (loginUserInfo == null) {
			setLoginUserInfo();
		}

		List<UserVO> user;

		try {
			HashMap<String, String> param = new HashMap<>();
			param.put("USER_ID", userId);

			user = ad010Service.list(param);
		} catch (Exception e) {
			logger.error(Constants.ERROR_SQL, e);
			user = new ArrayList<>();
		}

		return user;
	}

	@RequestMapping(value = "/ad010/save", method = RequestMethod.POST)
	public ResultVO ad010Save(@RequestBody UserVO user) throws Exception {
		logger.info("requestURL:" + context.getRequestURL() + "," + user);

		ResultVO result;

		if (loginUserInfo == null) {
			setLoginUserInfo();
		}

		try {
			user.USER_IP = loginUserInfo.USER_IP;
			user.LOGIN_USR_ID = loginUserInfo.LOGIN_USR_ID;

			ad010Service.save(user);
			result = new ResultVO("00", "OK");
		} catch (Exception e) {
			logger.error(Constants.ERROR_SQL, e);
			result = new ResultVO("99", Constants.ERROR_SQL + "\n" + e.getMessage());
		}

		return result;
	}
}