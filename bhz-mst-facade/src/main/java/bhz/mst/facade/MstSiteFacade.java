package bhz.mst.facade;

import java.util.List;

import com.alibaba.fastjson.JSONObject;

public interface MstSiteFacade {
	
	List<JSONObject> getList(JSONObject jsonParam, Integer start, Integer limit) throws Exception;

	int getTotal(JSONObject jsonParam);
	
	void insert(JSONObject jsonObject) throws Exception;
	
	int update(JSONObject json) throws Exception;
	
	JSONObject get(String siteId) throws Exception;
	
}
