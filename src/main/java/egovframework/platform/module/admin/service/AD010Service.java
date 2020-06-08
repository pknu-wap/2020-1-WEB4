package egovframework.platform.module.admin.service;

import egovframework.platform.module.base.BaseService;
import egovframework.platform.module.common.service.CommonService;
import egovframework.platform.module.common.vo.UserVO;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service("ad010Service")
public class AD010Service extends BaseService {
	@Autowired
	private DataSourceTransactionManager transactionManager;

	@Autowired
	protected CommonService commonService;

	public AD010Service() {
		super();

		nameSpace = "AD010Mapper";
		logger = LoggerFactory.getLogger(this.getClass());
	}

	// 사용자목록
	public List<UserVO> list(Map param) throws Exception {
		List<UserVO> user = sqlSessionTemplate.selectList(nameSpace + ".list", param);

		return user;
	}

	@Transactional
	public void save(UserVO user) throws Exception {
		if (user.IS_NEW.equals("Y")) {
			sqlSessionTemplate.insert(nameSpace + ".insert", user);
		} else {
			sqlSessionTemplate.update(nameSpace + ".update", user);
		}
	}
}