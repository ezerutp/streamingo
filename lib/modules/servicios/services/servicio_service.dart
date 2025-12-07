import 'package:streamingo/modules/servicios/domain/servicio.dart';
import 'package:streamingo/modules/servicios/repo/servicio_repo.dart';

class ServicioService {
  final ServicioRepository servicioRepository;

  ServicioService({required this.servicioRepository});

  // Obtener todos los servicios
  Future<List<Servicio>> fetchServicios() async {
    return await servicioRepository.getAll();
  }

  // Obtener un servicio por ID
  Future<Servicio?> fetchServicioById(int id) async {
    return await servicioRepository.getById(id);
  }

  // Crear nuevo servicio
  Future<int> createServicio(Servicio servicio) async {
    return await servicioRepository.save(servicio);
  }

  // Eliminar servicio
  Future<int> removeServicio(Servicio servicio) async {
    return await servicioRepository.delete(servicio);
  }

  // Actualizar servicio
  Future<int> modifyServicio(Servicio servicio) async {
    return await servicioRepository.update(servicio);
  }
}
