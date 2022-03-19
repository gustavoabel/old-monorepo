export interface Model {
  dispose: () => void;
  id: string;
}

export interface Editor {
  createModel: (libSource: string, language: string) => Model;
  getModels: () => Model[];
}
