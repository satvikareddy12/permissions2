package DAO;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import models.ApplyPermissions;

@Component
@Transactional
public class ApplyPermissionDaoImpl {

	@PersistenceContext
	@Qualifier("sessionFactory")
	private EntityManager em;

	public void persist(ApplyPermissions apppermission) {
		em.persist(apppermission);
	}

	public int getNextPermissionIndex(int employeeId) {
		String queryString = "SELECT COALESCE(MAX(pr.id.ep_index), 0) + CASE WHEN COUNT(pr) > 0 THEN 1 ELSE 0 END "
				+ "FROM ApplyPermissions pr WHERE pr.id.empl_id = :empl_id";
		Query query = em.createQuery(queryString);
		query.setParameter("empl_id", employeeId);
		return (Integer) query.getSingleResult();
	}

	public List<ApplyPermissions> adminViewPermission() {
		return em.createQuery("Select ap from ApplyPermissions ap").getResultList();
	}
	public ApplyPermissions getPermissionByIdAndIndex(int employeeId, int index) {
		String queryString = "SELECT ap FROM ApplyPermissions ap WHERE ap.id.empl_id = :empl_id AND ap.id.ep_index = :ep_index";
		TypedQuery<ApplyPermissions> query = em.createQuery(queryString, ApplyPermissions.class);
		query.setParameter("empl_id", employeeId);
		query.setParameter("ep_index", index);
		try {
			return query.getSingleResult();
		} catch (NoResultException e) {
			return null; // Return null when no permission is found
		}
	}




}
