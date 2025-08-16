package lab.demo

import it.unibo.scafi.incarnations.Incarnation

trait BuildingBlocks:
  self: Incarnation =>

  type ID = Int
  trait BlockG:
    self: AggregateProgram with StandardSensors =>
    def gradientCast[A](source: Boolean)(center: A)(accumulation: A => A): A =
      rep((Double.PositiveInfinity, center)) {
        accumulateData => {
          mux(source) {(0.0, center)} {
            foldhoodPlus((Double.PositiveInfinity, center))(minByFirst)(accumulateAndCast[A](nbr(accumulateData), accumulation))
          }
        }
      }._2

    private def accumulateAndCast[A](data: (Double, A), accumulation: A => A): (Double, A) =
      (data._1 + nbrRange(), accumulation(data._2))

  trait BlockT:
    self: AggregateProgram =>
    def decay[T](initial: T, floor: T)(decayWith: T => T): T =
      rep(initial) { value => mux(value == floor)(floor)(decayWith(value)) }


  trait BlockC:
    self: AggregateProgram with StandardSensors =>

    def collectCast[V](potential: Double)(local: V)(Null: V)(accumulation: (V, V) => V): V =
      rep(local):
        collected => accumulation(local, foldhood(Null)(accumulation){
          mux(nbr(findParent(potential)) == mid())(nbr(collected))(nbr(Null))
        })

    private def findParent(potential: Double): ID =
      val (minPotential, minId) = foldhood((Double.MaxValue, mid()))(minByFirst)(nbr((potential, mid())))
      if(minPotential < potential) minId else Builtins.Bounded.of_i.top

  protected def minByFirst[A](a: (Double, A), b: (Double, A)): (Double, A) =
    if (a._1 < b._1) a else b
