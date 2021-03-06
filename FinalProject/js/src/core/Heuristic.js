/**
 * @namespace PF.Heuristic
 * @description A collection of heuristic functions.
 */
class Heuristic{

    constructor(){

    }

  /**
   * Manhattan distance.
   * @param {number} dx - Difference in x.
   * @param {number} dy - Difference in y.
   * @return {number} dx + dy
   */
  manhattan(dx, dy, dz) {
      return dx + dy + dz;
  }

  /**
   * Euclidean distance.
   * @param {number} dx - Difference in x.
   * @param {number} dy - Difference in y.
   * @return {number} sqrt(dx * dx + dy * dy)
   */
  euclidean(dx, dy, dz) {
      return Math.sqrt(dx * dx + dy * dy + dz * dz);
  }

  /**
   * Chebyshev distance.
   * @param {number} dx - Difference in x.
   * @param {number} dy - Difference in y.
   * @return {number} max(dx, dy)
   */
  chebyshev(dx, dy, dz) {
      return Math.max(dx, dy, dz);
  }

};
