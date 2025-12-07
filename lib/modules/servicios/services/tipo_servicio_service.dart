import 'package:streamingo/modules/servicios/domain/tipo_servicio.dart';
import 'package:streamingo/modules/servicios/repo/tipo_servicio_repo.dart';

class TipoServicioService {
  final TipoServicioRepository tipoServicioRepository;

  TipoServicioService({required this.tipoServicioRepository});

  // Obtener todos los tipos de servicio
  Future<List<TipoServicio>> fetchTiposServicio() async {
    return await tipoServicioRepository.getAll();
  }

  // Obtener un tipo de servicio por ID
  Future<TipoServicio?> fetchTipoServicioById(int id) async {
    return await tipoServicioRepository.getById(id);
  }

  // Crear nuevo tipo de servicio
  Future<int> createTipoServicio(TipoServicio tipoServicio) async {
    return await tipoServicioRepository.save(tipoServicio);
  }

  // Eliminar tipo de servicio
  Future<int> removeTipoServicio(TipoServicio tipoServicio) async {
    return await tipoServicioRepository.delete(tipoServicio);
  }

  // Actualizar tipo de servicio
  Future<int> modifyTipoServicio(TipoServicio tipoServicio) async {
    return await tipoServicioRepository.update(tipoServicio);
  }
}
