import type {ViewProps} from 'ViewPropTypes';
import type {HostComponent} from 'react-native';
import codegenNativeComponent, {NativeComponentType} from 'react-native/Libraries/Utilities/codegenNativeComponent';
import {Float, boolean, DirectEventHandler} from "react-native/Libraries/Types/CodegenTypes";
import codegenNativeCommands from "react-native/Libraries/Utilities/codegenNativeCommands";

type ScrollEvent = Readonly<{
    x: Float;
    y: Float;
}>;

export interface NativeProps extends ViewProps {
    contentWidth: Float,
    bounce: boolean,
    showsIndicator: boolean,
    width: Float,
    height: Float,
    onScroll: DirectEventHandler<ScrollEvent>,
}

interface NativeCommands {
    setContentOffset: (
        viewRef: React.ElementRef<NativeComponentType<NativeProps>>,
        x: Float,
        y: Float,
    ) => void;
}

export const Commands: NativeCommands = codegenNativeCommands<NativeCommands>({
    supportedCommands: [
        'setContentOffset',
    ],
});

export default codegenNativeComponent<NativeProps>(
    'RNPageScrollView',
) as HostComponent<NativeProps>;
