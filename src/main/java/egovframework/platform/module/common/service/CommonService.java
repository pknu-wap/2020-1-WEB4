/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.platform.module.common.service;

import egovframework.platform.module.base.BaseService;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Service("commonService")
public class CommonService extends BaseService {
	@Autowired
	private DataSourceTransactionManager transactionManager;

	public CommonService() {
		super();

		nameSpace = "CommonMapper";
		logger = LoggerFactory.getLogger(this.getClass());
	}

	// 순번펑션 (독립적인 트랜잭션)
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public String selectSeq(String workGrp, String code) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("WORK_GRP", workGrp);
		param.put("CODE", code);

		String seq = sqlSessionTemplate.selectOne(nameSpace + ".selectSeq", param);

		return seq;
	}
}