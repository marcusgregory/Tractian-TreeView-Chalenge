abstract class Mapper<M, E> {
  M toModel(E entity);

  E toEntity(M model);

  List<M> toModels(List<E> entities) => entities.map(toModel).toList();

  List<E> toEntities(List<M> models) => models.map(toEntity).toList();
}
