package vo;
// category 테이블 VO(도메인객체) : VO, DTO, Domain
public class Category {
	public Category() {}
	// 정보은닉
	private String categoryName;
	private String createDate;
	private String updateDate;
	// 겟/셋터
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
}