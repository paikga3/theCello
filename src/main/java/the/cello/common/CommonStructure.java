package the.cello.common;

import java.util.List;

public interface CommonStructure<T> {
	public void saveOrUpdate(T item);
	public void delete(long id);
	public List<T> getList();
	public T getItem(long id);
}
