<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Department Management</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: Arial, sans-serif; background: #f4f6fb; padding: 1.5rem; color: #222; }

  .header {
    background: linear-gradient(135deg, #534AB7, #D4537E);
    border-radius: 12px;
    padding: 1.25rem 1.5rem;
    margin-bottom: 1.5rem;
    display: flex; align-items: center; gap: 12px;
  }
  .header i { font-size: 28px; color: #fff; }
  .header h1 { color: #fff; font-size: 20px; font-weight: 500; margin: 0; }
  .header p { color: rgba(255,255,255,0.75); font-size: 13px; margin: 0; }

  .card {
    background: #fff;
    border: 0.5px solid #e0e0e0;
    border-radius: 12px;
    padding: 1.25rem;
    margin-bottom: 1.5rem;
  }
  .card-title {
    font-size: 13px; font-weight: 600; color: #666;
    text-transform: uppercase; letter-spacing: .05em;
    margin-bottom: 1rem;
    display: flex; align-items: center; gap: 8px;
  }

  .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
  .form-group { display: flex; flex-direction: column; gap: 6px; }
  .form-group.full { grid-column: 1 / -1; }
  label { font-size: 13px; color: #555; font-weight: 500; }
  input, textarea {
    font-size: 14px; padding: 8px 12px;
    border: 0.5px solid #ccc; border-radius: 8px;
    background: #fff; color: #222; width: 100%; resize: vertical;
  }
  input:focus, textarea:focus {
    outline: none; border-color: #7F77DD;
    box-shadow: 0 0 0 3px rgba(127,119,221,0.15);
  }

  .btn-group { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 1rem; }
  .btn {
    display: inline-flex; align-items: center; gap: 6px;
    padding: 8px 16px; border-radius: 8px;
    font-size: 13px; font-weight: 500; border: none; cursor: pointer;
    transition: opacity .15s;
  }
  .btn:hover { opacity: .85; }
  .btn-create { background: #1D9E75; color: #fff; }
  .btn-update { background: #7F77DD; color: #fff; }
  .btn-delete { background: #E24B4A; color: #fff; }
  .btn-reset  { background: #f0f0f0; color: #333; border: 0.5px solid #ccc; }

  .search-row {
    display: flex; gap: 10px; margin-bottom: 1rem;
    align-items: center; flex-wrap: wrap;
  }
  .search-row input { max-width: 280px; }
  .badge-count {
    background: #EEEDFE; color: #534AB7;
    border-radius: 20px; padding: 2px 10px;
    font-size: 12px; font-weight: 500;
  }

  table { width: 100%; border-collapse: collapse; font-size: 14px; }
  thead tr { background: #f8f8fb; }
  th {
    text-align: left; padding: 10px 14px;
    font-size: 12px; font-weight: 600; color: #666;
    text-transform: uppercase; letter-spacing: .04em;
    border-bottom: 0.5px solid #e0e0e0;
  }
  td {
    padding: 10px 14px;
    border-bottom: 0.5px solid #f0f0f0;
    vertical-align: middle;
  }
  tr:last-child td { border-bottom: none; }
  tr:hover td { background: #fafafa; }

  .no-badge {
    background: #E6F1FB; color: #185FA5;
    border-radius: 20px; padding: 2px 8px;
    font-size: 12px; font-weight: 500;
  }
  .id-badge {
    background: #EEEDFE; color: #534AB7;
    border-radius: 6px; padding: 2px 8px;
    font-size: 12px; font-weight: 500; font-family: monospace;
  }
  .edit-btn {
    display: inline-flex; align-items: center; gap: 4px;
    background: #EEEDFE; color: #534AB7;
    border: none; border-radius: 6px;
    padding: 5px 12px; font-size: 12px; font-weight: 500;
    cursor: pointer; text-decoration: none; transition: background .15s;
  }
  .edit-btn:hover { background: #CECBF6; }
  .desc-text { color: #888; font-size: 13px; }
</style>
</head>
<body>

<c:url var="path" value="/department" />

<!-- HEADER -->
<div class="header">
  <i class="ti ti-building"></i>
  <div>
    <h1>Department Management</h1>
    <p>Quản lý danh sách phòng ban</p>
  </div>
</div>

<!-- FORM -->
<div class="card">
  <div class="card-title">
    <i class="ti ti-edit" style="font-size:16px"></i>
    Thông tin phòng ban
  </div>
  <form method="post">
    <div class="form-grid">
      <div class="form-group">
        <label>ID</label>
        <input name="id" value="${item.id}" placeholder="Nhập mã phòng ban">
      </div>
      <div class="form-group">
        <label>Tên phòng ban</label>
        <input name="name" value="${item.name}" placeholder="Nhập tên phòng ban">
      </div>
      <div class="form-group full">
        <label>Mô tả</label>
        <textarea name="description" rows="3" placeholder="Nhập mô tả...">${item.description}</textarea>
      </div>
    </div>
    <div class="btn-group">
      <button class="btn btn-create" formaction="${path}/create">
        <i class="ti ti-plus"></i> Thêm mới
      </button>
      <button class="btn btn-update" formaction="${path}/update">
        <i class="ti ti-pencil"></i> Cập nhật
      </button>
      <button class="btn btn-delete" formaction="${path}/delete">
        <i class="ti ti-trash"></i> Xóa
      </button>
      <button class="btn btn-reset" formaction="${path}/reset">
        <i class="ti ti-refresh"></i> Reset
      </button>
    </div>
  </form>
</div>

<!-- TABLE -->
<div class="card">
  <div class="search-row">
    <div class="card-title" style="margin:0">
      <i class="ti ti-list" style="font-size:16px"></i>
      Danh sách phòng ban
    </div>
    <span class="badge-count">${list.size()} phòng ban</span>
  </div>
  <table>
    <thead>
      <tr>
        <th>No.</th>
        <th>ID</th>
        <th>Tên phòng ban</th>
        <th>Mô tả</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="d" items="${list}" varStatus="vs">
      <tr>
        <td><span class="no-badge">${vs.count}</span></td>
        <td><span class="id-badge">${d.id}</span></td>
        <td>${d.name}</td>
        <td class="desc-text">${d.description}</td>
        <td>
          <a class="edit-btn" href="${path}/edit/${d.id}">
            <i class="ti ti-edit" style="font-size:14px"></i> Sửa
          </a>
        </td>
      </tr>
      </c:forEach>
    </tbody>
  </table>
</div>

</body>
</html>
